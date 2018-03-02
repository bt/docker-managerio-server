FROM ubuntu:xenial

# Configuration variables
ENV MANAGER_VER 18.1.89

# Install dependencies and Manager server
RUN set -x \
	&& apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF \
	&& echo "deb http://download.mono-project.com/repo/ubuntu stable-xenial main" | tee /etc/apt/sources.list.d/mono-official-stable.list \
	&& apt-get update \
	&& apt-get install -y mono-complete wget \
	&& mkdir /usr/share/manager-server \
	&& wget https://d2ap5zrlkavzl7.cloudfront.net/${MANAGER_VER}/ManagerServer.tar.gz -P /usr/share/manager-server \
	&& tar -xzf /usr/share/manager-server/ManagerServer.tar.gz -C /usr/share/manager-server

# Set work directory to the folder containing the server
WORKDIR /usr/share/manager-server

# Expose the HTTP port
EXPOSE 8080

# Run server in the foreground
CMD ["/usr/bin/mono", "/usr/share/manager-server/ManagerServer.exe", "-port", "8080"]