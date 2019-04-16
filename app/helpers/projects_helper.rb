module ProjectsHelper
    def get_membership(project)
      @member = ProjectMember.where(project: project, user: current_user).first
    end
end