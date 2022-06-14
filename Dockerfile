FROM cimg/ruby:3.1.2-node
MAINTAINER Alexander Bobrov, ITBeaver <al.bobrov@itbeaver.co>

# Install Chrome
RUN sudo apt-get update && sudo apt-get install -y wget
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' |  sudo tee /etc/apt/sources.list.d/google-chrome.list
RUN sudo apt-get update && sudo apt-get install -y google-chrome-stable
