module Jekyll

  class DataPage < Page
    def initialize(site, base, dir, name)
      @site = site
      @base = base
      @dir = dir
      @name = name
      self.process(@name)
      self.data ||= {}
      self.data['layout'] = 'default'
      self.data['title'] = data
    end
  end

  class CategoryPageGenerator < Generator
    def generate(site)
      datas = site.data['core']
      datas.each do |data|
        name = "#{data}.md"
        page = Jekyll::DataPage.new(site, site.source, @dir, name)
        page.data['title'] = data
        page.data['layout'] = 'default'
        page.content = "This is #{data}"
        site.pages << page
      end
    end
  end

end