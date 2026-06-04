executable_name=${PWD##*/}
executable_name=${executable_name:-/}
target="x86_64-unknown-linux-gnu"

cargo build --bin ${executable_name} --target-dir ./target --release --target $target
cp ./target/$target/release/${executable_name} .
