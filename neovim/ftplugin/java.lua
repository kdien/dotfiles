local jdtls = require('jdtls')
local home = os.getenv('HOME')
local java_home = os.getenv('JAVA_HOME')
local root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})
local mason_packages_root = home .. '/.local/share/nvim/mason/packages'
local workspace_dir = home .. '/.local/share/eclipse/' .. vim.fn.fnamemodify(root_dir, ':p:h:t')
local config = {}

config.settings = {
  java = {
    signatureHelp = { enabled = true },
    contentProvider = { preferred = 'fernflower' },
    completion = {
      favoriteStaticMembers = {
        'org.hamcrest.MatcherAssert.assertThat',
        'org.hamcrest.Matchers.*',
        'org.hamcrest.CoreMatchers.*',
        'org.junit.jupiter.api.Assertions.*',
        'java.util.Objects.requireNonNull',
        'java.util.Objects.requireNonNullElse',
        'org.mockito.Mockito.*'
      },
      filteredTypes = {
        'com.sun.*',
        'io.micrometer.shaded.*',
        'java.awt.*',
        'jdk.*',
        'sun.*',
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}'
      },
      hashCodeEquals = {
        useJava7Objects = true,
      },
      useBlocks = true,
    },
    configuration = {
      runtimes = {
        {
          name = 'JavaSE-1.8',
          path = '/usr/lib/jvm/java-1.8.0-openjdk/',
        },
        {
          name = 'JavaSE-11',
          path = '/usr/lib/jvm/java-11-openjdk/',
        },
        {
          name = 'JavaSE-17',
          path = '/usr/lib/jvm/java-17-openjdk/',
        },
      }
    },
  },
}

config.cmd = {
  java_home .. '/bin/java',
  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  '-Dosgi.bundles.defaultStartLevel=4',
  '-Declipse.product=org.eclipse.jdt.ls.core.product',
  '-Dlog.protocol=true',
  '-Dlog.level=ALL',
  '-Xmx4g',
  '--add-modules=ALL-SYSTEM',
  '--add-opens', 'java.base/java.util=ALL-UNNAMED',
  '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
  '-jar', vim.fn.glob(mason_packages_root .. '/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
  '-configuration', mason_packages_root .. '/jdtls/config_linux',
  '-data', workspace_dir,
}

config.on_attach = function(client, bufnr)
  -- jdtls.setup_dap({ hotcodereplace = 'auto' })
  jdtls.setup.add_commands()

  local opts = { silent = true, buffer = bufnr }
  vim.keymap.set('n', '<leader>oi>', jdtls.organize_imports, opts)
  vim.keymap.set('n', '<leader>dt', jdtls.test_class, opts)
  vim.keymap.set('n', '<leader>dm', jdtls.test_nearest_method, opts)
  vim.keymap.set('n', '<leader>xv', jdtls.extract_variable, opts)
  vim.keymap.set('v', '<leader>xm', vim.cmd("lua require('jdtls').extract_method(true)"), opts)
  vim.keymap.set('n', '<leader>xc', jdtls.extract_constant, opts)
  vim.keymap.set('n', '<leader>rui', function()
    vim.diagnostic.setqflist { severity = vim.diagnostic.severity.WARN }
    vim.cmd('packadd cfilter')
    vim.cmd('Cfilter /main/')
    vim.cmd('Cfilter /The import/')
    vim.cmd('cdo normal dd')
    vim.cmd('cclose')
    vim.cmd('wa')
  end)
end

local jar_patterns = {
  mason_packages_root .. '/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar',
  mason_packages_root .. '/java-test/extension/server/com.microsoft.java.test.plugin-*.jar',
  mason_packages_root .. '/java-test/extension/server/com.microsoft.java.test.runner-*.jar',
}
-- npm install broke for me: https://github.com/npm/cli/issues/2508
-- So gather the required jars manually; this is based on the gulpfile.js in the vscode-java-test repo
local plugin_path = mason_packages_root .. '/java-test/extension/server/'
local bundle_list = vim.tbl_map(
  function(x) return require('jdtls.path').join(plugin_path, x) end,
  {
    'org.eclipse.jdt.junit4.runtime_*.jar',
    'org.eclipse.jdt.junit5.runtime_*.jar',
    'org.junit.jupiter.api*.jar',
    'org.junit.jupiter.engine*.jar',
    'org.junit.jupiter.migrationsupport*.jar',
    'org.junit.jupiter.params*.jar',
    'org.junit.vintage.engine*.jar',
    'org.opentest4j*.jar',
    'org.junit.platform.commons*.jar',
    'org.junit.platform.engine*.jar',
    'org.junit.platform.launcher*.jar',
    'org.junit.platform.runner*.jar',
    'org.junit.platform.suite.api*.jar',
    'org.apiguardian*.jar'
  }
)
vim.list_extend(jar_patterns, bundle_list)
local bundles = {}
for _, jar_pattern in ipairs(jar_patterns) do
  for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
    if not vim.endswith(bundle, 'com.microsoft.java.test.runner-jar-with-dependencies.jar')
      and not vim.endswith(bundle, 'com.microsoft.java.test.runner.jar') then
      table.insert(bundles, bundle)
    end
  end
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

config.init_options = {
  bundles = bundles,
  extendedClientCapabilities = extendedClientCapabilities,
}

jdtls.start_or_attach(config)

