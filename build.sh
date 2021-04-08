

target=${1:-'default'}



case ${target} in
    'build')
        go get
        go build
        ;;
    'docker')
        SNAPSHOT=$(date '+%Y%m%d%H%M%S')
        docker build --rm --tag pushemulator:1.0.SNAPSHOT$SNAPSHOT .
        ;;
    'dockerrun')
        SNAPSHOT=$(date '+%Y%m%d%H%M%S')
        docker build --rm --tag pushemulator:1.0.SNAPSHOT$SNAPSHOT .
        docker run -p 8443:8443 pushemulator:1.0.SNAPSHOT$SNAPSHOT
        ;;
esac


#./node_modules/.bin/mc-docker-publish --docker-dir=.operations --image-dir .
#./node_modules/.bin/mc-kube-deploy --base-dir .
