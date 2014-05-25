import play.api.mvc.WithFilters
import com.googlecode.htmlcompressor.compressor.HtmlCompressor
import com.mohiva.play.htmlcompressor.HTMLCompressorFilter

object Global extends WithFilters( HTMLCompressorFilter() )

object HTMLCompressorFilter
{
	def apply() = new HTMLCompressorFilter(
	{
		new HtmlCompressor
		{
			setRemoveHttpProtocol( true )
			setRemoveHttpsProtocol( true )
			setRemoveIntertagSpaces( true )
			setRemoveQuotes( true )
			setSimpleBooleanAttributes( true )
		}
	} )
}