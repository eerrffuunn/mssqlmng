create or alter trigger [passUpdate] --creating triggrt
on [Customer]
    for insert, update -- for inser and update
as
if update (Password)--if password changed
	begin
		update Customer
		set [PasswordExpiry] = DATEADD(YEAR, 1,  GETDATE()) --add by one q 1 yeat
		from inserted i --temp row
		where Customer.ID = i.ID --update the inserted one by one year
	end