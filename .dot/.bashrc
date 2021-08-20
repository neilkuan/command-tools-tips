
### Create dir and cd it.
mkcdir ()
{
    mkdir -p -- "$1" &&
      cd -P -- "z$1"
}

###  BASH SILENCE DEPRECATION WARNING for mac termainal app.
export BASH_SILENCE_DEPRECATION_WARNING=1

### Get my Public IP.
export MYIP=`curl -s http://checkip.amazonaws.com/`

### AWS IAM WHOIAM. 
alias awswhoami='aws sts get-caller-identity'


alias checkip='curl -s http://checkip.amazonaws.com'
