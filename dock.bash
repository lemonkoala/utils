dockb() {
  if [ -z $1 ]; then
    echo "Please supply the container name / ID"
  else
    eval "docker exec -it $1 bash"
  fi
}

dockr() {
  if [ -z $1 ]; then
    echo "Please supply the container name / ID"
  else
    eval "docker restart $1"
  fi
}

dockp() {
  docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" \
    | awk -v search=$1 'NR == 1 || $0 ~ search' \
    | awk 'NR == 1; NR > 1 { print $0 | "sort" }' \
    | awk '
      NR == 1 {
        PORTSPOS = index($0, "PORTS");
        PORTS = "PORTS";
        PORTSPADDING = "\n";
        for(n = 1; n < PORTSPOS; n++)
          PORTSPADDING = PORTSPADDING " ";
      }

      NR > 1 {
        PORTS = substr($0, PORTSPOS);
        gsub(/, /, PORTSPADDING, PORTS);
      }

      {
        printf "%s%s\n", substr($0, 0, PORTSPOS - 1), PORTS;
      }
      '
}

docki() {
  docker images \
    --format "table {{.Repository}}\t{{.Tag}}\t{{.CreatedSince}}\t{{.Size}}" \
    | awk -v search=$1 'NR == 1 || $0 ~ search' \
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

dockn() {
  docker network ls
}

_dock_containers_autocomplete() {
  local cur=${COMP_WORDS[COMP_CWORD]}
  containers=`docker ps --format '{{.Names}}'`
  COMPREPLY=( $(compgen -W "${containers}" -- $cur) )
}
complete -F _dock_containers_autocomplete dockb dockr dockip

dockweb() {
  docker-compose run --rm web "$@"
}

dockclean() {
  docker rm -v $(docker ps     --filter status=exited -q 2>/dev/null) 2>/dev/null
  docker rmi   $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
  docker volume rm $(docker volume ls -qf dangling=true) 2>/dev/null
  docker network prune -f
}

alias dm='docker-machine'
alias dp='docker-compose'
