use decompress::ExtractOptsBuilder;
use std::path::PathBuf;

fn main() {}

fn deflate_archive(input_dir_full_path: PathBuf, tmp_dir_full_path: PathBuf) {
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
        println!("{:?}", rdf_xml_file_path);
    }
}

#[test]
fn test_convert() {
    let base_dir_path = std::env::current_dir().unwrap();
    let input_dir_full_path = base_dir_path.join("input");
    let tmp_dir_full_path = base_dir_path.join("tmp");
    let output_dir_full_path = base_dir_path.join("output");

    deflate_archive(input_dir_full_path, tmp_dir_full_path.clone());

    convert(tmp_dir_full_path, output_dir_full_path);
}
