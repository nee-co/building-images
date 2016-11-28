set -ex
BITBUCKET_REPO_SLUG="$1"
BITBUCKET_COMMIT="$2"

excluded_dirs() {
  for i in $(find . -maxdepth 1 -mindepth 1 -not -path *./.* -type d)
    do pushd $i > /dev/null &&

      export $1=${i#*/}
      [ -z $3 ] &&

        export imagename="registry.neec.xyz/neeco/${name#*-}:${tag#*-}"
        docker build --tag ${imagename} . &&
          docker push ${imagename}

      ${@:2}
    popd > /dev/null
  done
}

excluded_dirs name excluded_dirs tag

for i in latest $BITBUCKET_COMMIT
  do docker build  --tag registry.neec.xyz/neeco/$BITBUCKET_REPO_SLUG-application:$i git@bitbucket.org:nhac/$BITBUCKET_REPO_SLUG.git
done