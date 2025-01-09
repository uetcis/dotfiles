local config = {
  -- cmd = { 'env', 'JAVA_HOME=/usr/lib/jvm/java-22-openjdk', '/home/weitcis/.local/share/lvim/mason/bin/jdtls' },
  -- cmd = { 'env', 'JAVA_HOME=/usr/lib/jvm/java-17-openjdk', '/home/weitcis/.local/share/lvim/mason/bin/jdtls' },
  cmd = { '/home/weitcis/.local/share/lvim/mason/bin/jdtls' },
  root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
}
require('jdtls').start_or_attach(config)
