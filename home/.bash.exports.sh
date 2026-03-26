# ------------------------------------------------------------------------------
# Export Paths and Environment Variables
# ------------------------------------------------------------------------------

# CUDA Paths and Aliases
path_add /usr/local/cuda/bin
export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# ------------------------------------------------------------------------------
# EDA: Misc
# ------------------------------------------------------------------------------

# Verilator Path
path_add "$HOME/.local/verilator/bin"

# Fusesoc
path_add /home/freake/.local/bin

# ------------------------------------------------------------------------------
# EDA: Synopsys
# ------------------------------------------------------------------------------

if [ -n "${SNPSLMD_LICENSE_FILE_PRIVATE:-}" ]; then
	export SNPSLMD_LICENSE_FILE="${SNPSLMD_LICENSE_FILE_PRIVATE}"
fi
export SNPSLMD_QUEUE=true

path_add /opt/synopsys/installer
path_add /opt/synopsys/tools/vcs/X-2025.06-SP2-2/bin

export VCS_HOME=/opt/synopsys/tools/vcs/X-2025.06-SP2-2
export VERDI_HOME=/opt/synopsys/tools/verdi/X-2025.06-SP2-2
