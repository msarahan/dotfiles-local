gpg2 --import pubkey.asc

mkdir -p ~/.gnupg
cp ./gpg-agent.conf ~/.gnupg/gpg-agent.conf
echo D2ADA33B8E6147506BDC042618C79DCC59C89B6D >> ~/.gnupg/sshcontrol

# NOTE: if ssh key stops working, may be a problem with gpg agent:
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=835394
# run 
#   gpg-connect-agent updatestartuptty /bye 
# to reset it

sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# https://github.com/thoughtbot/dotfiles
git clone git@github.com:thoughtbot/dotfiles ~/dotfiles
if [ -e "$(which brew)" ]; then
  brew tap thoughtbot/formulae;
  brew install rcm;
else
  wget -qO - https://apt.thoughtbot.com/thoughtbot.gpg.key | sudo apt-key add -;
  echo "deb https://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list;
  sudo apt-get update;
  sudo apt-get install -y rcm;
fi

env RCRC=$HOME/dotfiles/rcrc rcup
