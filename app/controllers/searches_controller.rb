class SearchesController < ApplicationController

  def index
  end

  def search_data
    doc = Nokogiri::HTML(open("http://www.google.com/search?q=#{params[:search].gsub(' ', '+')}"))
    @data = doc.xpath('//h3/a')
    @nodes = @data.map{|ss| ss if ss.children.text.force_encoding("ISO-8859-1").encode("utf-8", replace: nil).split("for").first != "Images " }.compact
    @descriptions = doc.xpath('//span[@class="st"]').map{|ss| ss.text}
    respond_to do |format|
      format.js
    end
  end
end
