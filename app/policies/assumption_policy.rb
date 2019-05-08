class AssumptionPolicy < ApplicationPolicy

    def show?
      if user
        if ProjectMember.where(project: record.project, user: user).any?
          true
        else
          user.id == record.project.author.id || !record.project.is_private
        end
      else
        !record.project.is_private?
      end
    end

    def new?
      if user
        if ProjectMember.where(project: record.project, user: user).any?
          true
        else
          user.id == record.project.author.id || !record.project.is_private
        end
      end
    end

    def update?
      if user
        user.id == record.author_id
      end
    end

    def destroy?
      if user
        user.id == record.author_id
      end
    end

end
