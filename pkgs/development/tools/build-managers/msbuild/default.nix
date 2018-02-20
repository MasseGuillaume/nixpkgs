# { stdenv, fetchurl, fetchFromGitHub, fsharp, libssh2, git, cmake
# , autoconf, automake, pkgconfig, shared_mime_info, intltool
# , glib, mono, gtk-sharp-2_0, gnome2, gnome-sharp, unzip
# , dotnetPackages
# }:

{ stdenv, fetchFromGitHub, which, mono, curl, cacert, unzip}:

stdenv.mkDerivation rec {
  version = "15.4.8.50001";
  name = "msbuild-${version}";

  src = fetchFromGitHub {
    repo = "msbuild";
    owner = "Microsoft";
    rev = "v${version}";
    sha256 = "1mm66bjphjiiqw5bm6siwcbr9b96bbzb7xda4n1vb09jrqz8zlmp";
  };

  buildInputs = [
    which mono curl cacert unzip
  ];

  installPhase = ''
  export SSL_CERT_FILE="${cacert}/etc/ssl/certs/ca-bundle.crt"

  substituteInPlace cibuild.sh \
    --replace \
      "THIS_SCRIPT_PATH=\$(cd \"\$(dirname \"\$0\")\"; pwd -P)" \
      "THIS_SCRIPT_PATH=$out" \
    --replace \
      "eval \"\$THIS_SCRIPT_PATH/init-tools.sh\"" \
      "echo \"== Skiping init-tools.sh ==\""

  bash -x ./cibuild.sh --target Mono

  ls -lh $out
  '';
}