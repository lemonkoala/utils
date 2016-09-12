dockb() {
  if [ -z $1 ]; then
    echo "Please supply the container name / ID"
  else
    eval "docker exec -it $1 bash"
  fi
}

dockp() {
  docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Ports}}\t{{.Status}}" \
    | awk 'NR == 1; NR > 1 { print $0 | "sort"}'
}

docki() {
  docker images \
    --format "table {{.Repository}}\t{{.Tag}}\t{{.CreatedSince}}\t{{.Size}}" \
    | awk 'NR == 1; NR > 1 {print $0 | "sort"}'
}

dockip() {
  comm="docker inspect --format '{{.NetworkSettings.IPAddress}}' "

  if [ -z $1 ]; then
    echo -e "Container \t IP Address"

    for var in $(docker ps --format '{{.Names}}' | sort)
    do
      echo -e "$var \t $(eval $comm$var)"
    done
  else
    eval $comm$1
  fi
}

_dock_containers_autocomplete() {
  local cur=${COMP_WORDS[COMP_CWORD]}
  containers=`docker ps --format '{{.Names}}'`
  COMPREPLY=( $(compgen -W "${containers}" -- $cur) )
}
complete -F _dock_containers_autocomplete dockb dockip

dockweb() {
  docker-compose run --rm web "$@"
}

dockclean() {
  docker rm -v $(docker ps     --filter status=exited -q 2>/dev/null) 2>/dev/null
  docker rmi   $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}

alias dm='docker-machine'
alias dp='docker-compose'
