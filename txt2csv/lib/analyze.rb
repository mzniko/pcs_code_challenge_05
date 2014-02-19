#
class Analyze
  def initialize(input_file_name, output_file_name, fix)
    @input_file = File.new(input_file_name, 'r')
    @output_file = File.new(output_file_name, 'w')
    @fix = fix
  end

  def determine_fix
    case @fix

    when '-p'


    when '-s'  

      
    end

  def split_file
    separate = @input_file.each_line { |line| CSV.parse_line(line, :col_sep => '\t' ) }
  end  

  def 

    
  end


  end 