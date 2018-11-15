class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can [:read, :update], User, id: user.id
    can :read, School, id: user.school_id
    if user.has_role? :admin
      can :manage, :all
    elsif user.has_role? :manager 
      # Schools
      can :manage, School, id: user.school_id
      cannot :destroy, School, id: user.school_id
      # Programs
      can :create, Program
      can :manage, Program, school_id: user.school_id
      # Departments
      can :create, Department
      can :manage, Department, program: { school_id: user.school_id }
      # Courses
      can :create, Course
      can :manage, Course, department: { program: { school_id: user.school_id } }
      # Observations
      can :create, Observation
      can :manage, Observation, course: { department: { program: { school_id: user.school_id } } }
      # Interactions
      can :create, Interaction
      can :manage, Interaction, observation: { course: { department: { program: { school_id: user.school_id } } } }
      # Focuses
      can :create, Focus
      can :manage, Focus, school_id: user.school_id
      # Teachers
      can :create, Teacher
      can :manage, Teacher, school_id: user.school_id
      # Users
      can :create, User
      can :manage, User, school_id: user.school_id
    elsif user.has_role? :observer
      # Programs
      can :read, Program, school_id: user.school_id
      # Schools
      can :read, School, id: user.school_id
      # Programs
      can :read, Program, school_id: user.school_id
      # Departments
      can :read, Department, program: { school_id: user.school_id }
      # Courses
      can :create, Course
      can :read, Course, department: { program: { school_id: user.school_id } }
      cannot :destroy, Course
      # Observations
      can :create, Observation
      can :manage, Observation, user_id: user.id
      can :read, Observation, course: { department: { program: { school_id: user.school_id } } }
      cannot :destroy, Observation
      can :destroy, Observation, { user_id: user.id }
      # Interactions
      can :create, Interaction
      can :manage, Interaction, observation: { course: { department: { program: { school_id: user.school_id } } } }
      # Focuses
      can :create, Focus
      can :manage, Focus, school_id: user.school_id
      # Teachers
      can :create, Teacher
      can :manage, Teacher, school_id: user.school_id
    elsif user.has_role? :teacher
      # Programs
      can :read, Program, school_id: user.school_id
      # Courses
      # Observations
      # Teachers
    else
      cannot :read, :all
    end
  end
end
