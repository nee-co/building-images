set -e
build_opts="$@"

excluded_dirs() {
  for i in $(find . -maxdepth 1 -mindepth 1 -not -path *./.* -type d)
    do pushd $i > /dev/null &&

      export $1=${i#*/}
      [ -z $3 ] &&

        export imagename="registry.neec.xyz/neeco/${name#*-}:${tag#*-}"
        docker build ${build_opts} --tag ${imagename} . &&
          docker push ${imagename}

      ${@:2}
    popd > /dev/null
  done
}

excluded_dirs name excluded_dirs tag

for i in aldea caja cadena cuenta dios kong puerta
  do docker build git@bitbucket.org:nhac/$i.git -t registry.neec.xyz/neeco/$i:latest &&
     docker push registry.neec.xyz/neeco/$i:latest
done