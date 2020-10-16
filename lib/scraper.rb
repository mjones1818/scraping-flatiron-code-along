require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative './course.rb'

class Scraper
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    url = 'http://learn-co-curriculum.github.io/site-for-scraping/courses'
    html = open(url)
    @html_parsed_to_elements = Nokogiri::HTML(html)
    
  end
  
  def get_courses
    self.get_page
    course_elements = @html_parsed_to_elements.css('.post')
  end

  def make_courses
    @course = []
    get_courses.each do |parsed_html|
      course = Course.new
      course.title = parsed_html.css('h2').text
      course.schedule = parsed_html.css('em').text
      course.description = parsed_html.css('p').text
    end
  end

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
end
Scraper.new.print_courses