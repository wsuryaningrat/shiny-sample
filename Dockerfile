# Base image for Python
# FROM python:3.8


# Base image https://hub.docker.com/u/rocker/
FROM rocker/shiny-verse:latest

#Disable Selinux#
# RUN echo 'SELINUX=disabled' > /etc/selinux/config

# system libraries of general use
## install debian packages
RUN apt-get update -qq && apt-get -y --no-install-recommends install \
    libxml2-dev \
    libcairo2-dev \
    libsqlite3-dev \ 

######Install PhantomJS#####

# RUN cd ~
# RUN wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2
# RUN tar xvjf phantomjs-1.9.8-linux-x86_64.tar.bz2
# RUN mv phantomjs-1.9.8-linux-x86_64 /usr/local/share
# RUN ln -sf /usr/local/share/phantomjs-1.9.8-linux-x86_64/bin/phantomjs /usr/local/bin

## update system libraries
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

# Delete file in folder app
RUN rm -rf /app

# copy necessary files to the app folder
COPY / ./app

# install packages
RUN Rscript /app/install_packages.R


# install python dependencies
# RUN pip install -r requirements.txt

#symlink folder host to container

#RUN rm -rf /app/Temp
#RUN ln -s /apps/datalis-config/api.transaction_data/Data /app/Temp
#RUN ln -s /apps/scorecard/source/api_scorecard /app/scorecard


# expose port
EXPOSE 8888

# run app on container start
CMD ["R", "-e", "shiny::runApp('/app', host = '0.0.0.0', port = 8888)"]
