# Start with a base Ruby image
ARG RUBY_VERSION=3.4.4
FROM ruby:$RUBY_VERSION-slim

# Set environment variables
ENV RAILS_ENV=production \
    BUNDLE_WITHOUT="development:test" \
    BUNDLE_DEPLOYMENT=true \
    BUNDLE_JOBS=4 \
    LANG=C.UTF-8 \
    RAILS_SERVE_STATIC_FILES=true \
    RAILS_LOG_TO_STDOUT=true

# Install essential build tools and Node.js + Yarn for asset pipeline
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    libpq-dev \
    libsqlite3-dev \
    libvips \
    # Node.js for assets:precompile
    nodejs \
    yarn \
    && rm -rf /var/lib/apt/lists/*

# Set up working directory for the application.
# The Docker build context is the root of the project.
# We will copy the entire project into /app_root
# and then set the working directory to the dummy app.
WORKDIR /app_root

# Copy Gemfile and Gemfile.lock from the project root
COPY Gemfile Gemfile.lock ./

# Install gems. This will install all gems defined in the root Gemfile,
# including daisy_components itself (due to `gemspec` directive)
# and its dependencies.
RUN bundle install

# Copy the entire application code into the container
COPY . .

# Set the working directory to the dummy Rails application
WORKDIR /app_root/test/dummy

# Precompile assets for the dummy application
# Ensure this is run from the context of the dummy app
RUN bundle exec rake assets:precompile

# Expose port 3000 (standard Rails port)
EXPOSE 3000

# Default command to start the Rails server for the dummy app
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
