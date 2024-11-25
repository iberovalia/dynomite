#!/bin/bash

# Configure tmp dir
mkdir -p /tmp/dynomite

# Create config file based on environment variables
cat > /tmp/dynomite/redis_single.yml << EOF
dyn_o_mite:
  dyn_listen: $PEER_ADDRESS
  datacenter: $DATACENTER
  rack: $RACK
  data_store: 0
  listen: $LISTEN_ADDRESS
  dyn_seed_provider: simple_provider
  servers:
    - $REDIS_SERVER
  tokens: 437425602
EOF

# Add dyn_seeds section if DYNOMITE_SEED is set
if [ ! -z "$DYNOMITE_SEED" ]; then
  cat >> /tmp/dynomite/redis_single.yml << EOF
  dyn_seeds:
    - $DYNOMITE_SEED
EOF
fi

# Print config file
cat /tmp/dynomite/redis_single.yml

# Start Dynomite
src/dynomite --conf-file=/tmp/dynomite/redis_single.yml -v5
