# frozen_string_literal: true

class GroupFactory
  def initialize(author, project)
    @params = { author: author, project: project }
  end

  def create!
    [
      {
        title: 'Problem Statement',
        description: 'A brief description of the problem, who faces it, why ' \
                     'it’s an issue and the importance of solving it.'
      },
      {
        title: 'Problem Area',
        description: 'Our understanding of the problem from the perspectives ' \
                     'of those affected and the outcomes to realise.'
      },
      { title: 'User Value',
        description: "How your solutions meet people's needs, expectations " \
                     'and behaviours.'
      },
      {
        title: 'Social Value',
        description: 'How your solutions contribute to the resolution of a ' \
                     'social issue and/or avoid negative consequences for ' \
                     'people and planet.'
      },
      {
        title: 'Financial Value',
        description: 'How you grow and sustain your solutions.'
      }
    ].each do |attributes|
      Group.create(attributes.merge(@params))
    end
  end
end
