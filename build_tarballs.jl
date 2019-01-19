# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

name = "libatomic_ops"
version = v"7.6.8"

# Collection of sources required to build libatomic_ops
sources = [
    "https://github.com/ivmai/libatomic_ops/releases/download/v7.6.8/libatomic_ops-7.6.8.tar.gz" =>
    "1d6a279edf81767e74d2ad2c9fce09459bc65f12c6525a40b0cb3e53c089f665",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd libatomic_ops-7.6.8/
./configure --prefix=$prefix --host=$target --enable-shared --disable-docs
make
make install
exit

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:x86_64, libc=:glibc)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libatomic_ops_gpl", :libatomic_ops_gpl),
    LibraryProduct(prefix, "libatomic_ops", :libatomic_ops)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies)

