pkg_name=tomlcheck
pkg_origin=ya
pkg_version="0.1.0.38"
pkg_maintainer="Yauhen Artsiukhou <jsirex@gmail.com>"
pkg_license=("BSD-3-Clause")
pkg_source="https://github.com/vmchale/tomlcheck/releases/download/${pkg_version}/${pkg_name}-x86_64-unkown-linux-gnu"
pkg_filename="${pkg_name}"
pkg_shasum="118d26a04f8e463a21f53ddd7fd0394dadfe2164bb1c686d4f861d92862f2575"

pkg_deps=(core/glibc core/gmp)
pkg_build_deps=(core/patchelf)
pkg_bin_dirs=(bin)

do_unpack() {
    pushd "${HAB_CACHE_SRC_PATH}" > /dev/null
    chmod +x "$pkg_name"
    popd
}

do_build() {
    return 0
}

do_install() {
    cp "${HAB_CACHE_SRC_PATH}/$pkg_name" "$pkg_prefix/bin/$pkg_name"
    patchelf --interpreter "$(pkg_path_for core/glibc)/lib/ld-linux-x86-64.so.2" \
             --set-rpath "$LD_RUN_PATH" "$pkg_prefix/bin/$pkg_name" \
              "$pkg_prefix/bin/$pkg_name"
}

do_strip() {
    return 0
}
