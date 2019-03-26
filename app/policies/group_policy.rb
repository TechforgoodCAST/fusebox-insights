class GroupPolicy < ApplicationPolicy
    def update?
        user.id == record.author_id
    end

    def destroy?
        user.id == record.author_id
    end
    
end
