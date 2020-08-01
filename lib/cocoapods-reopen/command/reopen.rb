module Pod
  class Command
    # This is an example of a cocoapods plugin adding a top-level subcommand
    # to the 'pod' command.
    #
    # You can also create subcommands of existing or new commands. Say you
    # wanted to add a subcommand to `list` to show newly deprecated pods,
    # (e.g. `pod list deprecated`), there are a few things that would need
    # to change.
    #
    # - move this file to `lib/pod/command/list/deprecated.rb` and update
    #   the class to exist in the the Pod::Command::List namespace
    # - change this class to extend from `List` instead of `Command`. This
    #   tells the plugin system that it is a subcommand of `list`.
    # - edit `lib/cocoapods_plugins.rb` to require this file
    #
    # @todo Create a PR to add your plugin to CocoaPods/cocoapods.org
    #       in the `plugins.json` file, once your plugin is released.
    #
    class Reopen < Command
      self.summary = 'Reopen the workspace'
      self.description = <<-DESC
        Close and opens the workspace in Xcode. If no workspace found in the current directory,
        looks up parent it finds one.
      DESC

      def initialize(argv)
        @workspace = find_workspace_in(Pathname.pwd)
        super
      end

      def validate!
        super
        raise Informative, 'No xcode workspace found' unless @workspace
      end

      def run
        ascript = <<~STR.strip_heredoc
          tell application "Xcode"
                  set docs to (document of every window)
                  repeat with doc in docs
                      if class of doc is workspace document then
                          set docPath to path of doc
                          if docPath begins with "#{@workspace}" then
                              log docPath
                              close doc
                              return
                          end if
                      end if
                  end repeat
          end tell
        STR
        `osascript -e '#{ascript}'`
        `open "#{@workspace}"`
      end

      private

      def find_workspace_in(path)
        puts "find xcworkspace at #{path}"
        path.children.find { |fn| fn.extname == '.xcworkspace' } || find_workspace_in_example(path)
      end

      def find_workspace_in_example(path)
        tofind = path + 'Example'
        find_workspace_in(tofind) if tofind.exist?
      end
    end
  end
end
