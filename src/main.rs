use decompress::ExtractOptsBuilder;
use oxrdfxml::RdfXmlParser;
use oxttl::TurtleSerializer;
use std::path::PathBuf;

const QUIRE_FRAGMENT_TO_REPLACE_1: &str =
    r#"<crm:E54_Dimension><crm:P91_has_unit>quire</crm:P91_has_unit><crm:P90_has_value>"#;
const QUIRE_FRAGMENT_REPLACER_1: &str =
    r#"<crm:E54_Dimension crm:P91_has_unit="quire" crm:P90_has_value=""#;
const QUIRE_FRAGMENT_TO_REPLACE_2: &str = r#"</crm:P90_has_value></crm:E54_Dimension>"#;
const QUIRE_FRAGMENT_REPLACER_2: &str = r#"0" />"#;

fn main() {
    let base_dir_path = std::env::current_dir().unwrap();
    let input_dir_full_path = base_dir_path.join("input");
    let tmp_dir_full_path = base_dir_path.join("tmp");
    let output_dir_full_path = base_dir_path.join("output");

    //decompress_archive(input_dir_full_path, tmp_dir_full_path.clone());

    convert(tmp_dir_full_path, output_dir_full_path);
}

fn decompress_archive(input_dir_full_path: PathBuf, tmp_dir_full_path: PathBuf) {
    let archives_glob = glob::Pattern::new("full*.zip").expect("wrong glob pattern for archives");
    let archive_globbed_path = input_dir_full_path.join(archives_glob.as_str());

    let mut archive_file_paths: Vec<PathBuf> = glob::glob(archive_globbed_path.to_str().unwrap())
        .expect("Failed to read glob pattern")
        .filter_map(Result::ok)
        .collect();
    archive_file_paths.sort();

    // select the latest archive
    let latest_archive_file_path = archive_file_paths.pop().unwrap();

    // copy the latest archive to the output folder and unzip it
    //fs::copy(latest_archive_file_path, output_dir_full_path).unwrap();
    let extract_opts = ExtractOptsBuilder::default()
        .strip(1)
        .filter(|path| {
            let path_as_str = path.to_str().unwrap();

            path_as_str.contains("/tmp/rdf/") && !path_as_str.ends_with("__contents__.xml")
            //
        })
        .build()
        .unwrap();
    decompress::decompress(latest_archive_file_path, tmp_dir_full_path, &extract_opts).unwrap();
}

fn convert(tmp_dir_full_path: PathBuf, output_dir_full_path: PathBuf) {
    let rdf_xml_files_glob =
        glob::Pattern::new("**/*.rdf").expect("wrong glob pattern for archives");
    let rdf_xml_files_globbed_path = tmp_dir_full_path.join(rdf_xml_files_glob.as_str());

    for rdf_xml_file_path in glob::glob(rdf_xml_files_globbed_path.to_str().unwrap())
        .expect("Failed to read the glob pattern")
        .filter_map(Result::ok)
    {
        let file_basename = rdf_xml_file_path.file_stem().unwrap().display();
        let rdf_xml_file_contents = std::fs::read_to_string(&rdf_xml_file_path).unwrap();
        let rdf_xml_file_processed_contents = rdf_xml_file_contents
            .replace(
                "dcterms:hasPart rdf:resource=\"",
                "dcterms:hasPart rdf:resource=\"https://betamasaheft.eu/",
            )
            .replace(
                "crm:P55_has_current_location rdf:resource=\"",
                "crm:P55_has_current_location rdf:resource=\"https://betamasaheft.eu/",
            )
            .replace(QUIRE_FRAGMENT_TO_REPLACE_1, QUIRE_FRAGMENT_REPLACER_1)
            .replace(QUIRE_FRAGMENT_TO_REPLACE_2, QUIRE_FRAGMENT_REPLACER_2)
            .replace(
                "https://betamasaheft.eu/https://betamasaheft.eu/",
                "https://betamasaheft.eu/",
            )
            .replace(" \"/>", "\"/>");

        let mut serializer = TurtleSerializer::new().for_writer(Vec::new());

        for triple in RdfXmlParser::new().for_slice(rdf_xml_file_processed_contents.as_bytes()) {
            let triple = triple.unwrap();

            serializer.serialize_triple(triple.as_ref()).unwrap();
        }

        let result = serializer.finish().unwrap();

        std::fs::write(
            output_dir_full_path.join(format!("{}.ttl", file_basename)),
            result,
        )
        .unwrap();
    }
}

#[test]
fn test_convert() {
    let base_dir_path = std::env::current_dir().unwrap();
    let input_dir_full_path = base_dir_path.join("input");
    let tmp_dir_full_path = base_dir_path.join("tmp");
    let output_dir_full_path = base_dir_path.join("output");

    //decompress_archive(input_dir_full_path, tmp_dir_full_path.clone());

    convert(tmp_dir_full_path, output_dir_full_path);
}
