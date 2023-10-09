local jdtls = require('jdtls')

local home = os.getenv('HOME')
local jdtls_server_dir = home .. '/.config/nvim/dependencies/jdtls'

local config_os = 'linux'
if vim.fn.has('mac') == 1 then
  config_os = 'mac'
end

local java_paths = {}
java_paths['8'] = '/usr/lib/jvm/java-1.8.0-openjdk/'
java_paths['11'] = '/usr/lib/jvm/java-11-openjdk/'
java_paths['17'] = '/usr/lib/jvm/java-17-openjdk/'

for ver, path in pairs(java_paths) do
  if vim.fn.isdirectory(path) ~= 1 then
    java_paths[ver] = string.sub(path, 1, string.len(path) - 1) .. '-amd64/'
  end
end

-- Find root of project
local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
local root_dir = require('jdtls.setup').find_root(root_markers)
if root_dir == '' then
  return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = home .. '/eclipse-workspace/' .. project_name

local bundles = {}
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. '/.config/nvim/dependencies/vscode-java-test/server/*.jar'), '\n'))
vim.list_extend(
  bundles,
  vim.split(
    vim.fn.glob(
      home ..
      '/.config/nvim/dependencies/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'
    ),
    '\n'
  )
)

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    'java', -- or '/path/to/java11_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. home .. '/.config/nvim/dependencies/lombok.jar',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',

    '-jar',
    vim.fn.glob(jdtls_server_dir .. '/plugins/org.eclipse.equinox.launcher_*.jar'),

    '-configuration',
    jdtls_server_dir .. '/config_' .. config_os,

    '-data',
    workspace_dir,
  },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = root_dir,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- or https://github.com/redhat-developer/vscode-java#supported-vs-code-settings
  -- for a list of options
  settings = {
    java = {
      -- jdt = {
      --   ls = {
      --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
      --   }
      -- },
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = 'interactive',
        runtimes = {
          {
            name = 'JavaSE-1.8',
            path = java_paths['8']
          },
          {
            name = 'JavaSE-11',
            path = java_paths['11']
          },
          {
            name = 'JavaSE-17',
            path = java_paths['17']
          },
        }
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = 'all', -- literals, all, none
        },
      },
      format = {
        enabled = false,
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        'org.hamcrest.MatcherAssert.assertThat',
        'org.hamcrest.Matchers.*',
        'org.hamcrest.CoreMatchers.*',
        'org.junit.jupiter.api.Assertions.*',
        'java.util.Objects.requireNonNull',
        'java.util.Objects.requireNonNullElse',
        'org.mockito.Mockito.*',
      },
    },
    contentProvider = { preferred = 'fernflower' },
    extendedClientCapabilities = extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
      },
      useBlocks = true,
    },
  },

  flags = {
    allow_incremental_sync = true,
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = bundles,
  },

  on_attach = function()
    require('jdtls').setup_dap { hotcodereplace = 'auto' }
    require('jdtls.dap').setup_dap_main_class_configs()

    local opts = { silent = true, buffer = nil }
    vim.keymap.set('n', '<leader>oi', jdtls.organize_imports, opts)
    vim.keymap.set('n', '<leader>dt', jdtls.test_class, opts)
    vim.keymap.set('n', '<leader>dm', jdtls.test_nearest_method, opts)
    vim.keymap.set('n', '<leader>xv', jdtls.extract_variable, opts)
    vim.keymap.set('v', '<leader>xm', "<Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
    vim.keymap.set('n', '<leader>xc', jdtls.extract_constant, opts)

    -- Remove unused imports
    vim.keymap.set('n', '<leader>rui', function()
      vim.diagnostic.setqflist { severity = vim.diagnostic.severity.WARN }
      vim.cmd('packadd cfilter')
      vim.cmd('Cfilter /main/')
      vim.cmd('Cfilter /The import/')
      vim.cmd('cdo normal dd')
      vim.cmd('cclose')
      vim.cmd('wa')
    end, opts)
  end
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)

vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
vim.cmd "command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
vim.cmd "command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()"
-- vim.cmd "command! -buffer JdtJol lua require('jdtls').jol()"
vim.cmd "command! -buffer JdtBytecode lua require('jdtls').javap()"
-- vim.cmd "command! -buffer JdtJshell lua require('jdtls').jshell()"

local dap = require('dap')
dap.configurations.java = {
  {
    type = 'java',
    request = 'attach',
    name = 'Debug (Attach) - Remote',
    hostName = '127.0.0.1',
    port = 30303,
  },
}
