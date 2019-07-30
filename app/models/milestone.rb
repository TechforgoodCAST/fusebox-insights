class Milestone < ApplicationRecord
  belongs_to :project
  
  PRESETS = [
    {
      title: "Validated user needs",
      description: "Have a solid understanding of the problem space from the perspective of a well-defined user group."
    },
    {
      title: "Validated approach",
      description: "By the end of this stage you will know the exact problem you’re solving for the user and how you’re going to do it."
    },
    {
      title: "Developed MVP",
      description: "By the end of this stage you will have a working digital product and a plan for how your will test and pilot it with real users."
    }
  ]
  
end
