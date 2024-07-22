<script lang="ts">
  import Email from "./components/email.svelte";
    let container1Items: Array<{ id: number, part: string, option: string, name: string, order: number, score: number, feedback: string }>= [
        
    ];

    let container2Items: Array<{ id: number, part: string, option: string, name: string, order: number, score: number, feedback: string }> = [
      // Thank
  { id: 1, part: 'thank', option: "A", name: 'Thank you for sharing your situation with me; it takes courage to reach out.', order: 1, score: 5, feedback: "Shows empathy and appreciation for the student's effort to communicate." },
  { id: 2, part: 'thank', option: "B", name: 'Thanks for letting me know about your situation.', order: 1, score: 3, feedback: "Acknowledges the student's message but lacks depth in empathy." },
  { id: 3, part: 'thank', option: "C", name: 'Thanks for reaching out! I\'m glad you felt comfortable telling me about this.', order: 1, score: 4, feedback: "Shows positivity and appreciation but less formal." },
  
  // Acknowledge
  { id: 4, part: 'acknowledge', option: "A", name: 'I understand that balancing family responsibilities and schoolwork can be incredibly tough. Your role at home and the need to use library resources are significant hurdles.', order: 2, score: 5, feedback: "Demonstrates deep understanding and empathy towards the student's situation while subtly addressing the problems." },
  { id: 5, part: 'acknowledge', option: "B", name: 'You have mentioned that you have to care for your siblings, lack a quiet place to study, and rely on the library for internet access, which closes early.', order: 2, score: 4, feedback: "Parrots back the student's issues, focusing on the facts but lacking empathetic tone." },
  { id: 6, part: 'acknowledge', option: "C", name: 'It sounds like you have a lot going on, and it’s great that you’re managing to stay involved in your schoolwork despite these challenges.', order: 2, score: 3, feedback: "Skirts around the problem, highlighting positives but may come off as less serious." },

  // Solution
  { id: 7, part: 'solution', option: "A", name: 'I recommend checking if there are any local community centres or organisations that offer after-school programmes or day care services.', order: 3, score: 4, feedback: "Provides practical advice but might require additional steps from the student." },
  { id: 8, part: 'solution', option: "B", name: 'I can provide offline resources so you can work on assignments at home at night.', order: 3, score: 5, feedback: "Offers a direct and immediate solution to help the student manage their workload." },
  { id: 9, part: 'solution', option: "C", name: 'How about we ask some classmates to form a study group and help each other out?', order: 3, score: 3, feedback: "Suggests peer support but may not address the core issues directly, and can seem overly optimistic." },
  { id: 10, part: 'solution', option: "D", name: 'To help you manage your time better, I can provide you with extended deadlines for assignments and additional time for exams.', order: 3, score: 5, feedback: "Provides a structured and supportive solution that accommodates the student's needs." },

  // Final Words
  { id: 11, part: 'finalWords', option: "A", name: 'Your success is important to me, and I want to ensure you have the support necessary to thrive.', order: 4, score: 2, feedback: "Oversteps personal boundaries; too personal and may make the student uncomfortable." },
  { id: 12, part: 'finalWords', option: "B", name: 'I know you can handle this, and I\'m here to help.', order: 4, score: 4, feedback: "Provides confidence and assurance, but with a more direct tone." },
  { id: 13, part: 'finalWords', option: "C", name: 'You’re doing great managing everything, and I’m here to support you all the way.', order: 4, score: 3, feedback: "Offers enthusiastic support but may come off as overly optimistic, potentially invalidating the student's struggles." }
    ];
</script>

<Email {container1Items} {container2Items} />