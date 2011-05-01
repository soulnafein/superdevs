class CodeSnippet < ActiveRecord::Base
  belongs_to :author, :class_name => User.to_s

  validates_presence_of :title, :code, :language, :description

  def self.get_latest
    self.order('created_at DESC')
  end

  acts_as_commentable

  def self.languages
    [
      ['Bash', 'bash'],
      ['C#', 'csharp'],
      ['C/C++', 'cpp'],
      ['CSS', 'css'],
      ['Groovy', 'groovy'],
      ['JavaScript', 'js'],
      ['Java', 'java'],
      ['PHP', 'php'],
      ['Plain Text', 'plain'],
      ['Python', 'py'],
      ['Ruby', 'ruby'],
      ['Scala', 'scala'],
      ['SQL', 'sql'],
      ['XML', 'xml']
    ]
  end
end
