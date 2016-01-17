require_relative "helper"

text = %q(some text without escapable characters).html_safe

benchmark do |x|
  x.report("hmote") { __hmote(text: text) }
  x.report("rails") { __rails(text: text) }
  x.compare!
end

# Calculating -------------------------------------
#                hmote    29.474k i/100ms
#                rails    15.039k i/100ms
# -------------------------------------------------
#                hmote    376.579k (± 5.0%) i/s -      1.886M
#                rails    180.706k (± 5.1%) i/s -    902.340k
#
# Comparison:
#                hmote:   376579.0 i/s
#                rails:   180705.7 i/s - 2.08x slower

memory { __rails(text: text) }
# {:allocations=>11, :memsize=>1078}

memory { __hmote(text: text) }
# {:allocations=>6, :memsize=>479}
