#!/usr/bin/env ruby

require "csv"

#float = to_i
#use string interpolation for strings instead of +

all_strings = 
  (String.instance_methods - Comparable.instance_methods - Object.instance_methods)
ignore_strings = 
   %i[ % + +@ -@ << [] []= ascii_only? b bytes bytesize byteslice capitalize capitalize! casecmp 
       center chars chop chop! chomp chr codepoints chomp! clear concat count crypt  
       delete delete! downcase! dump each_char each_line each_codepoint encode encode! 
       encoding end_with? force_encoding getbyte hex intern lines ljust next! 
       oct partition prepend replace reverse! rjust rpartition scan 
       scrub scrub! scrub setbyte size squeeze! start_with? strip! 
       succ succ! sum swapcase swapcase! to_c to_f to_i to_r to_str tr tr! 
       tr_s tr_s! unicode_normalize unicode_normalize! unicode_normalized? unpack
       upcase! valid_encoding? ]
       
       #me.tr_s("a-z","") as opposed to regex
    
puts "\n\nSTRINGS" 
puts good_strings = (all_strings - ignore_strings).sort

all_enum = 
  Enumerable.instance_methods.sort
ignore_enum = 
  %i[ chain chunk chunk_while collect collect_concat detect drop drop_while each_cons 
      each_entry each_with_object each_with_index entries find find_all 
      find_index first grep grep_v lazy max member? max_by min min_by minmax 
      none? one? slice_after slice_before slice_when sum tally take take_while ]

puts "\n\nENUMERABLE " 
puts good_enum = (all_enum - ignore_enum).sort

all_array = 
  Array.instance_methods - Enumerable.instance_methods - Object.instance_methods
ignore_array =
  %i[ * []= << assoc at .bsearch bsearch_index clear collect! compact compact! concat 
      deconstruct delete delete_at delete_if dig each each_index empty? fetch fill flatten
      flatten! index keep_if last length map! pack pop push rassoc reject! 
      repeated_combination repeated_permutation replace reverse reverse! rindex
      rotate rotate! sample select! shuffle shuffle! shift size slice slice! 
      sort! sort_by! to_ary transpose uniq! unshift ]#( * not used as args, just use subtract - to remove) ]
       
puts "\n\nARRAY" 
puts good_array = (all_array - ignore_array).sort


all_hash = Hash.instance_methods - Enumerable.instance_methods - Object.instance_methods
ignore_hash =
  %i[ []= < <= > >= assoc clear compact compare_by_identity compare_by_identity? default default=
      default_proc default_proc= delete delete_if deconstruct_keys dig each each_key each_pair 
      each_value empty? fetch fetch_values flatten has_key? has_value? index keep_if key 
      key? keys length merge! rassoc rehash reject! replace select! size slice
      shift store transform_keys transform_keys! transform_values transform_values! 
      to_hash to_proc update value? values values_at ]
      
puts "\n\nHASH" 
puts good_hash = (all_hash - ignore_hash).sort


all_range = Range.instance_methods - Enumerable.instance_methods - Object.instance_methods
ignore_range =
  %i[ bsearch each end exclude_end? last size step ] 
puts "\n\nRANGE"
puts good_range = (all_range - ignore_range).sort

=begin

result = 0.29 #=> text element on page
two_decimal_places = 1/100.to_f

puts reselt.between?(result - two_decimal_places, result + two_decimal_places)

#puts "fine" if (res > res - two_decimal_places) || (res < res + two_decimal_places)

("A".."Z").to_a

=end


all_enumerator = Enumerator.instance_methods - Enumerable.instance_methods - Object.instance_methods
ignore_enumerator =
  %i[+ each feed next next_values peek peek_values rewind size]  
puts "\n\nENUMERATOR" 
puts good_enumerator = (all_enumerator - ignore_enumerator).sort

puts "======== #{RUBY_VERSION}==========="
arry = 
  [ Array, Enumerator, Hash, Range, File, IO, Dir, CSV ]

puts arry.map{|x| x.ancestors.include?(Enumerable)}

remove_from_Kernel = %i[
Array
Complex
Float
Hash
Integer
Rational
String
__callee__
__dir__
__method__
abort
at_exit
autoload
autoload?
binding
block_given?
caller
caller_locations
callcc
catch
chomp
chop
eval
exec
fail
fork
format
gem_original_require
global_variables
initialize_clone
initialize_copy
initialize_dup
iterator?
load
loop
open
iterator
lambda
local_variables
printf
proc
putc
raise
readline
readlines
respond_to_missing?
select
set_trace_func
spawn
sprintf
syscall
srand
test
throw
trace_var
trap
untrace_var
warn
]

p (Kernel.private_instance_methods(false).sort - remove_from_Kernel).sort

p "=========================================================="

remove_from_Object = %i[
!~
<=>
===
=~
display
enum_for
inspect
itself
is_a?
public_send
!
!= 
==
__id__
__send__
clone
define_singleton_method
dup
eql?
extend
freeze
frozen?
hash
in
instance_eval
instance_exec
instance_of?
instance_variable_defined?
instance_variable_get
instance_variable_set
instance_variables
kind_of?
method
private_methods
protected_methods
public_method
respond_to?
remove_instance_variable
singleton_class
singleton_method
singleton_methods
taint
tainted?
to_s
trust
trusted?
untaint
untrust
untrusted?
 ]


p (Object.instance_methods.sort - remove_from_Object).sort

p good_number_methods = %i[
  % divmod ** << >> chr denominator downto even? gcd integer?
  next ord pred round size to_i to_f upto eql? round step
  
  
  ]

#  THE BELOW BEHAVIOUR CAN'T BE RIGHT , SO I MIGHT NEED TO RAISE A BUG
#   irb(main):035:0> me = { a: 3, b: 4 }
# irb(main):036:0> me.deconstruct_keys([:name]) # => { name: 'Aaron' }
# => {:a=>3, :b=>4}
# irb(main):037:0> me.deconstruct_keys([:a]) # => { name: 'Aaron' }
# => {:a=>3, :b=>4}
