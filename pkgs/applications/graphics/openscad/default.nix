{ stdenv, fetchurl, qt4, qmake4Hook, bison, flex, eigen, boost, mesa, glew, opencsg, cgal
, mpfr, gmp, glib, pkgconfig, harfbuzz, qscintilla, gettext
}:

stdenv.mkDerivation rec {
  version = "2015.03-3";
  name = "openscad-${version}";

  src = fetchurl {
    url = "http://files.openscad.org/${name}.src.tar.gz";
    sha256 = "0djsgi9yx1nxr2gh1kgsqw5vrbncp8v5li0p1pp02higqf1psajx";
  };

  buildInputs = [
    qt4 qmake4Hook bison flex eigen boost mesa glew opencsg cgal mpfr gmp glib
    pkgconfig harfbuzz qscintilla gettext
  ];

  qmakeFlags = [ "VERSION=${version}" ];

  doCheck = false;

  meta = {
    description = "3D parametric model compiler";
    longDescription = ''
      OpenSCAD is a software for creating solid 3D CAD objects. It is free
      software and available for Linux/UNIX, MS Windows and macOS.

      Unlike most free software for creating 3D models (such as the famous
      application Blender) it does not focus on the artistic aspects of 3D
      modelling but instead on the CAD aspects. Thus it might be the
      application you are looking for when you are planning to create 3D models of
      machine parts but pretty sure is not what you are looking for when you are more
      interested in creating computer-animated movies.
    '';
    homepage = http://openscad.org/;
    license = stdenv.lib.licenses.gpl2;
    platforms = stdenv.lib.platforms.linux;
    maintainers = with stdenv.lib.maintainers;
      [ bjornfor raskin the-kenny ];
  };
}
