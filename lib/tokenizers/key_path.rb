module TwitterCldr
  module Tokenizers
    class KeyPath
      class << self
        def dirname(path)
          self.join_path(self.split_path(path)[0..-2])
        end

        def join(*args)
          final = ""
          args.each do |arg|
            fixed_arg = arg.chomp(".")
            fixed_arg = arg[1..-1] if fixed_arg[0].chr == "."
            final << "." if final.size > 0
            final << fixed_arg
          end
          final
        end

        def split_path(path)
          path.split(/\./)
        end

        def join_path(path_arr)
          path_arr.join(".")
        end
      end
    end
  end
end