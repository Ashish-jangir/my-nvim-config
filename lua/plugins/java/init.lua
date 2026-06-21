if true then
  return {}
end

return {
  "nvim-java/nvim-java",
  config = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          -- Your JDTLS configuration goes here
          jdtls = {
            settings = {
              java = {
                jdt = {
                  ls = {
                    vmargs = table.concat({
                      "-XX:+UseParallelGC",
                      "-XX:GCTimeRatio=4",
                      "-XX:AdaptiveSizePolicyWeight=90",
                      "-Dsun.zip.disableMemoryMapping=true",
                      "-XX:+UseStringDeduplication",
                      "-XX:+HeapDumpOnOutOfMemoryError",
                      "-Xmx2G", -- For small project Xmx2G, for medium -Xmx4G, for Huge monorepo -Xmx6G
                      "-Xms100m",
                    }, " "),
                  },
                },
                --     configuration = {
                --       runtimes = {
                --         {
                --           name = "JavaSE-23",
                --           path = "/usr/local/sdkman/candidates/java/23-tem",
                --         },
                --       },
                --     },
              },
            },
          },
        },
        setup = {
          jdtls = function()
            -- Your nvim-java configuration goes here
            require("java").setup({
              -- root_markers = {
              --   "settings.gradle",
              --   "settings.gradle.kts",
              --   "pom.xml",
              --   "build.gradle",
              --   "mvnw",
              --   "gradlew",
              --   "build.gradle",
              --   "build.gradle.kts",
              -- },
            })
          end,
        },
      },
    },
  },
}
