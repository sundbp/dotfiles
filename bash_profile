# @2012 Patrik Sundberg

source ~/.bash_ssh_agent_funcs.sh

# only bother with ssh agent in interactive sessions
if [ "$TERM" = "rxvt-unicode-256color" ];then
  setup_ssh_agent_env
fi

# let's source the bashrc at end of login
if [ -e ~/.bashrc ]; then
  source ~/.bashrc
fi
