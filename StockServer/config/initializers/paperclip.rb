#Paperclip::Attachment.default_options[:url] = 'stock-earning-cal.s3-website-us-east-1.amazonaws.com'
#Paperclip::Attachment.default_options[:path] = '/media/images/:class/:attachment/:id_partition/:style/:filename'
#Paperclip::Attachment.default_options[:s3_host_name] = 's3-website-us-east-1.amazonaws.com'

#class Paperclip::CommandLine
#  def full_path(binary)
#    [self.class.path, binary].compact.join((File::ALT_SEPARATOR||File::SEPARATOR))
#  end
#end if defined?(Paperclip::CommandLine)
#
#Paperclip.options[:command_path] = 'C:/PROGRA~1/IMAGEM~1.9-Q'