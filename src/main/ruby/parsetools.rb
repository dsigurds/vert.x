include Java
require "buffer"

module ParserTools

  class RecordParser

    class OutputCallback < org.nodex.core.Callback
      def initialize(output_block)
        super()
        @output_block = output_block
      end

      def onEvent(java_frame)
        @output_block.call(java_frame);
      end
    end

    def initialize(java_parser)
      @java_parser = java_parser
    end

    def call(data)
      input(data)
    end

    def input(data)
      @java_parser.on_event(data._to_java_buffer)
    end

    def RecordParser.new_delimited(delim, enc = "UTF-8", proc = nil, &output_block)
      output_block = proc if proc
      RecordParser.new(org.nodex.core.parsetools.RecordParser.newDelimited(delim, enc, OutputCallback.new(output_block)))
    end

    def RecordParser.new_bytes_delimited(bytes, proc = nil, &output_block)
      output_block = proc if proc
      RecordParser.new(org.nodex.core.parsetools.RecordParser.newDelimited(bytes, OutputCallback.new(output_block)))
    end

    def RecordParser.new_fixed(size, proc = nil, &output_block)
      output_block = proc if proc
      RecordParser.new(org.nodex.core.parsetools.RecordParser.newFixed(size, OutputCallback.new(output_block)))
    end

    def delimited_mode(delim, enc)
      @java_parser.delimitedMode(delim, enc)
    end

    def bytes_delimited_mode(bytes)
      @java_parser.delimitedMode(bytes)
    end

    def fixed_mode(size)
      @java_parser.fixedSizeMode(size)
    end

    private :initialize
  end

end