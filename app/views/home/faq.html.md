Peer4commit FAQ
===============

What is Peer4commit?
--------------------
Peer4commit is a website where anyone can raise funds for any kind of project.

How is it different than other crowdfunding sites?
--------------------------------------------------

On Peer4commit the fundraiser is not expected to actually do the work. His job is to collect funds and distribute them to the people who make the project happen. He may for example reward commits on an open source project or pay a lobbyist.

The fundraiser can also do the whole work if he wants to. Whatever he chooses, he will have to explain that in his project description so that potential sponsors know what's going to happen with their funds. The fundraiser can for example reward himself for his raising and distribution job, but that must be clear since the beginning.

Another difference is that Peer4commit uses Peercoin as the base currency. More currencies will come later, notably Bitcoin.


How can I get paid?
-------------------

Browse the projects and read descriptions to see if there's something you can do. There are so many possibilities it's hard to give a guideline. Actually we hope projects will appear to reward people who makes it easier for potential contributors to find something to do.


What can a fundraiser do with the funds?
----------------------------------------

He can distribute them to anyone he wants.

Peer4commit provides tools to help him doing that. He can for example send funds to an email address. Peer4commit will then send an email to ask where the funds should be sent. He can also send funds to a GitHub users, or to the author of a particular commit. More options will be added later: send to a Reddit user, to a peercointalk.org member, etc.

Peer4commit helps the fundraiser to gather payment informations from users. For example to set the receiving address of a GitHub account, you must log in with your GitHub account.


How is scam prevented?
----------------------

We don't want to restrict the power of the fundraisers. They were trusted by the donors so we let them do anything they want with the funds. The donors must be careful when they give. The fundraiser can take all the funds and disappear, so you must ensure he is trustworthy. You must also make sure he has the ability to acheive what he announces.

However we want to give the sponsors the most possible information to help them decide whether a particular fundraiser is trustworthy and able to do the job.

The system keeps track of all the projects and distributions made by each fundraiser. You can browse them on his profile page.

And all projects, distributions and users can be commented.

A reputation system will certainly be added later. A project should be created on Peer4commit for that.

But the most important part is that anyone can create a project and multiple people can raise funds for similar projects. So we hope fundraiser will actually compete on trust. Newcomers will have to prove their trustworthiness on small projects and gain reputation. With time their will be well trusted fundraisers who handled many of projects. They may even live by that.


How do I donate to a project I like?
------------------------------------

Browse the project list and click on "Donate". You will be asked for a personnal address that will be used if Peer4commit or the fundraiser ever needs to identify you. Then Peer4commit will give you an address to which you just have to send Peercoins. 99% of your donation will be available to the fundraiser. 1% will be kept to host Peer4commit and pay the transaction fees.

You can also donate without providing an address. But the fundraiser won't be able to return you the funds if he ever wants to. And if the fundraiser organizes a vote or send rewards, you won't be able to participate.


How can I raise funds?
----------------------

Click on "Create a project". You'll have to fill a description. Make it the most complete possible and provide proofs of your trustworthiness and abilities.

The project is visible on the project list but will not be particularly highlighted. You will have to communicate about it, that's part of your job. Explain your project on forums, Reddit, etc.

Do you have an audit page?
--------------------------
Yes, it shows different information, such as amount donated, available balance, transaction fees, amount in cold storage and includes addresses for each project. You can view the page <%= link_to "here", audit_path %>.

What measures have been taken to secure the funds on Peer4commit?
-----------------------------------------------------------------
The project funds are isolated in different accounts in the wallet, so if someone ever finds a way to distribute more funds than the project balance, Peercoin will not take the funds from another project and will refuse the transaction. Projects with a high balance have a part of its funds moved to cold storage. This is still a manual operation, but will soon be automated. The website runs in an isolated virtual server running only this service.

In the future the funds will be sent to a multisignature address so that the fundraiser and Peer4commit must agree to send the funds.

Contact
-------
If you have any question send a message to <%= mail_to "contact@peer4commit.com" %> or <%= link_to "open an issue on GitHub", "https://github.com/sigmike/peer4commit/issues/new" %>.

