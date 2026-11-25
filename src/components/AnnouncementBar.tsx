export function AnnouncementBar({ messages }: { messages: string[] }) {
  if (!messages.length) return null;
  return (
    <div className="announce">
      <ul className="announce__list" role="list">
        {messages.map((text) => (
          <li key={text}>{text}</li>
        ))}
      </ul>
    </div>
  );
}
