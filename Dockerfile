FROM texlive/texlive:latest

ENV DEBIAN_FRONTEND=noninteractive

# Create a working directory
WORKDIR /app

# Install required packages
RUN apt-get update -y
RUN apt-get install -y --no-install-recommends \
	make \
	pandoc
RUN rm -rf /var/lib/apt/lists/* \
	&& apt-get autopurge -y \
	&& apt-get autoclean -y

# Generate the mtxrun configuration
RUN mtxrun --generate

# Create directory structure
RUN mkdir output

# Copy files from local filesystem
COPY pandoc-resume-generator/markdown /app/markdown
COPY pandoc-resume-generator/styles /app/styles
COPY pandoc-resume-generator/Makefile /app/
COPY pandoc-resume-generator/pdc-links-target-blank.lua /app/

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]