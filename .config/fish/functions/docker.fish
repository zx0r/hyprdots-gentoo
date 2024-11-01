# # If Docker is installed, define abbreviations for Docker commands
if type -q docker
    function d
        docker $argv
    end

    function dim
        docker images
    end

    function dp
        docker ps
    end

    function dpa
        docker ps -a
    end

    function dpq
        docker ps -q
    end

    function drmc
        docker rm -v (docker ps -qaf status=exited)
    end

    function drmca
        docker rm -fv (docker ps -qa)
    end

    function drmi
        docker rmi (docker images -qf dangling=true)
    end

    function drmig
        docker rmi (docker images -qf reference=)
    end
end

# If Docker Compose is installed, define abbreviations for Docker Compose commands
if type -q docker-compose
    function dc
        docker-compose $argv
    end

    function dcl
        docker-compose logs
    end
end

# If kubectl is installed, define abbreviations for kubectl commands
if type -q kubectl
    function kb
        kubectl $argv
    end

    function kbg
        kubectl get $argv
    end

    function kbd
        kubectl describe $argv
    end

    function kbl
        kubectl logs $argv
    end
end
