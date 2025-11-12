# site.pp — node classification

# Default node (safe no-op)
node default {
  notify { 'Default node, no baseline applied': }
}

# Our managed agent node
node 'server-agent' {
  include profile::baseline
}
