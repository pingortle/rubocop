# frozen_string_literal: true

module RuboCop
  module Cop
    module Layout
      # Checks for semicolon (;) preceded by space.
      #
      # @example
      #   # bad
      #   x = 1 ; y = 2
      #
      #   # good
      #   x = 1; y = 2
      class SpaceBeforeSemicolon < Cop
        include SpaceBeforePunctuation

        def_node_matcher :block_with_shadowargs?, <<-PATTERN
          (block _ (args ... shadowarg) _)
        PATTERN

        def investigate(processed_source)
          super unless block_with_shadowargs?(processed_source.ast)
        end

        def autocorrect(space)
          PunctuationCorrector.remove_space(space)
        end

        def kind(token)
          'semicolon' if token.semicolon?
        end
      end
    end
  end
end
