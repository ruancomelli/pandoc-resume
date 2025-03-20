# A git clone stage
FROM alpine/git:2.47.2 AS cloner

# Clone the repository and checkout specific commit
RUN git clone https://github.com/mszep/pandoc_resume.git /app/pandoc_resume \
	&& cd /app/pandoc_resume \
	&& git checkout b5abc55e0cbe54b132069c9c487c81d6f10b8679

# Final stage to build the pdf
FROM texlive/texlive:latest

ENV DEBIAN_FRONTEND=noninteractive

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

# Create a working directory
WORKDIR /app

# Create directory structure
RUN mkdir -p /app/pandoc_resume/markdown /app/pandoc_resume/output

# Copy only the necessary files from the cloner stage
COPY --from=cloner /app/pandoc_resume/markdown /app/pandoc_resume/markdown
COPY --from=cloner /app/pandoc_resume/styles /app/pandoc_resume/styles
COPY --from=cloner /app/pandoc_resume/Makefile /app/pandoc_resume/
COPY --from=cloner /app/pandoc_resume/pdc-links-target-blank.lua /app/pandoc_resume/

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]