{ stdenv, fetchurl, perl, dpkg }:

stdenv.mkDerivation rec {
  pname = "bdf2psf";
  version = "1.191";

  src = fetchurl {
    url = "mirror://debian/pool/main/c/console-setup/bdf2psf_${version}_all.deb";
    sha256 = "0bqhn9rwrjipj7wd6c8i7rq39fc5jj5nc3mir931mfakknakkimk";
  };

  buildInputs = [ dpkg ];

  dontConfigure = true;
  dontBuild = true;

  unpackPhase = "dpkg-deb -x $src .";
  installPhase = "
    substituteInPlace usr/bin/bdf2psf --replace /usr/bin/perl ${perl}/bin/perl
    mv usr/bin .
    cp -r . $out
  ";

  meta = with stdenv.lib; {
    description = "BDF to PSF converter";
    homepage = https://packages.debian.org/sid/bdf2psf;
    longDescription = ''
      Font converter to generate console fonts from BDF source fonts
    '';
    license = licenses.gpl2;
    maintainers = with maintainers; [ rnhmjoj vrthra ];
    platforms = platforms.unix;
  };
}
