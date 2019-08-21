name 'coturn'
maintainer 'QubitRenegade'
maintainer_email 'qubitrenegade@protonmail.com'
license 'MIT'
description 'Installs/Configures coturn'
long_description 'Installs/Configures coturn'
version '0.1.0'
chef_version '>= 13.0'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/coturn/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/coturn'

depends 'certbot-exec'
depends 'certbot-exec-cloudflare'
