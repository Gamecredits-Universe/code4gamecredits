Peer4commit FAQ
===============

What is Peer4commit?
--------------------
Peer4commit is a website where anyone can raise funds for any kind of project.

How is it different than other crowdfunding sites?
--------------------------------------------------
On Peer4commit the fundraiser is not expected to do the actual work. His job is to collect funds and distribute them to the people who work on the project. He may for example reward commits on an open source project or pay a lobbyist.

Why?
----
The goal is give the initiative to the people, and not only to those who are able to achieve projects.

For example imagine you want a feature in an open source software but the developers don't care about it and you can't implement it yourself. You can start a project on Peer4commit to make this happen. If you get enough funds you can pay someone to implement the feature. There are many freelance developers and companies who will be happy to do that for you.

Or imagine you favorite band has given up. You can raise funds to pay them to work on a new album.


Why give control to a fundraiser and not directly to the people?
----------------------------------------------------------------
Giving direct control to multiple persons is a complex task with no ideal solution. For example are decisions made at the majority? Is there a quorum? Can people vote for multiple choices? Are votes proportional to the amount you gave?

And there is a big risk. For example if all decisions are made proportional to the amount given, then someone can easily take over the funds by sending more than everybody else. He can then send the whole funds to himself.

So we decided all these choices will be made by the fundraiser. He can start a project where he decides everything as a benevolent dictator, but he can also create more democratic projects where important decisions will be taken at the majority among choices he selects.

The fundraiser will also have the responsibility of deciding what can be changed and what can not. For example the main goal of the project is not likely to change. Even if you give a small amount and have a small weight in the decisions you can be assured that your funds will still be used for the same goal. Someone who gave 90% of the funds won't be able to change that.


Why use Peer4commit then and not send funds directly to the fundraiser?
-----------------------------------------------------------------------

Peer4commit provides tools to the donors and the fundraisers.

The donors can browse the fundraiser history: what projects he managed, how he distributed funds, what comments he received, etc. The fundraisers are forced to distribute the funds through Peer4commit so that anyone can see the details. For example if the fundraiser decided to send money to a GitHub account, then the GitHub account name will be displayed, not only the payment address.

The fundraisers have tools to easily distribute money. They can for example send funds to an email address. Peer4commit will take charge of getting payment information from the owner of this email address. They can also send funds to a GitHub users or to the author of a particular commit. More options will be added later (send to a Reddit user, to a forum member, etc.).

We also provide tools to identify donors. When they donate they can provide a address. This address will be used whenever Peer4commit, the fundraiser or anyone wants to identify a donor. Anyone able to sign with this address will be considered the sender of the associated money. This can be used to return the funds, to organize votes, to send rewards, etc.


Can I trust the fundraisers?
----------------------------

Not blindly. You should do some researches before you give money.

For example the fact a project has a lot of donations is not an indication that many people trust the fundraiser. He may have sent the money himself.

Peer4commit provides some tools to help you check the fundraiser. We keep track of all the projects he managed and all the funds he distributed. You can browse that and see how he managed previous projects. Anyone can comment the projects, distributions and users so if he did something wrong then there are good chances he received bad comments.

The fundraiser should also explain in the project description why you can trust him. If he doesn't do that you should be suspicious. Then you'll have to evaluate what he says. It's particularly important to check the identity of the fundraiser. He should provide proofs he is not impersonating the person he claims to be.

But an important point is that the fundraisers will actually compete on trust. Since anyone can raise funds a big part of the difference will be made on trustworthiness. Of course other skills are important too. For example the project may require some technical skills to evaluate the work made by others. You should ensure the fundraiser has these skills.


Does it work?
-------------
The project is still young but yes. Some projects were successfully managed.

We initially started as a [tip4commit](http://tip4commit.com/) clone where GitHub commits were automatically rewarded 1% of the balance. We moved recently to the more generic system described here.

Examples of successful projects:
* [Peer4commit](http://peer4commit.com/projects/1) itself
* [A Peercoin marketing video](http://peer4commit.com/projects/68)
* [Peerunity](http://peer4commit.com/projects/74)

Currency
--------
For now the only supported currency is <%= link_to "Peercoin", "http://peercoin.net/" %>. Support for other currencies will be added later.


How can I raise funds?
----------------------
Click on the <%= link_to '"Create a project"', new_project_path %> button. You'll have to fill a description. Make it the most complete possible and provide proofs of your trustworthiness and abilities.

The project will be visible on Peer4commit but it will not be particularly highlighted. You will have to communicate about it, that's part of your job.


Can fundraisers get paid for their work?
----------------------------------------
Yes. A fundraisers can send money to himself for his raising and distributing jobs. He can also reward himself to do actual work. That's up to him.

Fundraisers should explain in the project description whether they intend to pay themselves and how much.


How can I get paid to do the actual work?
-----------------------------------------
Browse the projects and read descriptions to see if there's something you can do and contact the fundraiser. There are so many possibilities it's hard to give a guideline.

We hope projects will appear to make things easier for potential contributors to find something to do.


How do I donate to a project I like?
------------------------------------
Browse the project list and click on the "Donate" button. You will be asked for a personal address that will be used if Peer4commit or the fundraiser ever needs to identify you. Then Peer4commit will give you an address to which you just have to send Peercoins. 99% of your donation will be available to the fundraiser. 1% will be kept to host Peer4commit and pay the transaction fees.

You can also donate without providing an address. But the fundraiser won't be able to return you the funds if he ever wants to. And if the fundraiser organizes a vote or send rewards, you won't be able to participate.


Do you have an audit page?
--------------------------
Yes, it shows different information, such as amount donated, available balance, transaction fees, amount in cold storage and includes addresses for each project. You can view the page <%= link_to "here", audit_path %>.

What measures have been taken to secure the funds on Peer4commit?
-----------------------------------------------------------------
The project funds are isolated in different accounts in the wallet, so if someone ever finds a way to distribute more funds than the project balance, Peercoin will not take the funds from another project and will refuse the transaction. Projects with a high balance have a part of its funds moved to cold storage. The website runs in an isolated virtual server running only this service.

In the future the funds will be sent to a multisignature address so that the fundraiser and Peer4commit must agree to send the funds.

Contact
-------
If you have any question send a message to <%= mail_to "contact@peer4commit.com" %> or <%= link_to "open an issue on GitHub", "https://github.com/sigmike/peer4commit/issues/new" %>.

