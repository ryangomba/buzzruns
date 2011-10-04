class User < ActiveRecord::Base
    belongs_to :athlete
    validates_presence_of :username, :hashed_password, :salt
    validates_uniqueness_of :username
    attr_protected :id, :salt

    def self.authenticate(username, password)
        u.find(:first, :conditions => ["username = ?", username])
        return nil if u.nil?
        return u if User.encrypt(password, u.salt)==u.hashed_password
    end

    def password=(pass)
        @password=pass
        self.salt = User.random_string(10) if !self.salt?
        self.hashed_password = User.encrypt(@password, self.salt)
    end

    protected

    def self.encrypt(pass, salt)
        Digest::SHA1.hexdigest(pass+salt)
    end

    def self.random_string(len)
        chars = ("a".."z").to_a + ("A".."Z").to_a + ("0"..."9").to_a
        newpass = ""
        1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
        return newpass
    end

end
