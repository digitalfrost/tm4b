# encoding: utf-8

require 'rexml/document'

module TM4B
   class BalanceCheck
      attr_accessor :balance

      def parameters
         {
            "type" => "check_balance",
            "version" => "2.1"
         }
      end

      def raw_response=(body)
         document = REXML::Document.new(body)

         @balance = {}

         REXML::XPath.match(document, "/result/*").each do |node|
            currency = node.name
            amount   = node.children[0].value.to_f

            @balance[currency] = amount
         end
      end

      def to_s
         "TM4B::BalanceCheck\n" + balance.map {|currency, amount| "\t#{currency}: #{amount}" }.join("\n")
      end
   end
end